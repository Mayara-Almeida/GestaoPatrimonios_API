using CsvHelper;
using CsvHelper.Configuration;
using GestaoPatrimonios.Applications.Mapeamentos;
using GestaoPatrimonios.Applications.Regras;
using GestaoPatrimonios.Domains;
using GestaoPatrimonios.DTOs.PatrimonioDto;
using GestaoPatrimonios.Exceptions;
using GestaoPatrimonios.Interfaces;
using System.Drawing;
using System.Globalization;
using static System.Net.Mime.MediaTypeNames;

namespace GestaoPatrimonios.Applications.Services
{
    public class PatrimonioService
    {
        private readonly IPatrimonioRepository _repository;

        public PatrimonioService (IPatrimonioRepository repository)
        {
            _repository = repository;
        }

        public List<ListarPatrimonioDto> Listar()
        {
            List<Patrimonio> patrimonios = _repository.Listar();

            List<ListarPatrimonioDto> patrimoniosDto = patrimonios.Select(patrimonio => new ListarPatrimonioDto
            {
                PatrimonioID = patrimonio.PatrimonioID,
                Denominacao = patrimonio.Denominacao,
                NumeroPatrimonio = patrimonio.NumeroPatrimonio,
                Valor = patrimonio.Valor,
                Imagem = patrimonio.Imagem,
                LocalizacaoID = patrimonio.LocalizacaoID,
                StatusPatrimonioID = patrimonio.StatusPatrimonioID
            }).ToList();

            return patrimoniosDto;
        }

        public ListarPatrimonioDto BuscarPorId(Guid patrimonioId)
        {
            Patrimonio patrimonio = _repository.BuscarPorId(patrimonioId);

            if(patrimonio == null)
            {
                throw new DomainException("Patrimônio não encontrado.");
            }

            return new ListarPatrimonioDto
            {
                PatrimonioID = patrimonio.PatrimonioID,
                Denominacao = patrimonio.Denominacao,
                NumeroPatrimonio = patrimonio.NumeroPatrimonio,
                Valor = patrimonio.Valor,
                Imagem = patrimonio.Imagem,
                LocalizacaoID = patrimonio.LocalizacaoID,
                StatusPatrimonioID = patrimonio.StatusPatrimonioID
            };
        }

        public void Adicionar(IFormFile arquivoCsv, Guid usuarioId)
        {
            if (arquivoCsv == null || arquivoCsv.Length == 0)
            {
                throw new DomainException("Arquivo CSV é obrigatório.");
            }

            Localizacao localizacaoSemLocal = _repository.BuscarLocalizacaoPorNome("Sem local"); // Ao importar patrimônio a localização vem como "sem local"

            if (localizacaoSemLocal == null)
            {
                throw new DomainException("Localização 'Sem local' não cadastrada.");
            }

            StatusPatrimonio statusAtivo = _repository.BuscarStatusPatrimonioPorNome("Ativo"); // Ao importar patrimônio o status vem como "ativo"

            if (statusAtivo == null)
            {
                throw new DomainException("Status 'Ativo' não cadastrado.");
            }

            TipoAlteracao tipoAlteracao = _repository.BuscarTipoAlteracaoPorNome("Atualização de dados");

            if (tipoAlteracao == null)
            {
                throw new DomainException("Tipo de alteração 'Atualização de dados' não cadastrado.");
            }

            List<ImportarPatrimonioCsvDto> registros;

            // Abre o arquivo enviado por IFormFile
            using (var stream = arquivoCsv.OpenReadStream())

            // Lê o arquivo como texto
            using (var reader = new StreamReader(stream))

            // Cria leitor de CSV com configurações personalizadas
            // CultureInfo -> Define como números, datas e textos são interpretados 
            // InvariantCulture -> Define que vai ser interpretado no formato de padrão universal ex:1,500.00
            using (var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                // Define que o separador é o ponto vírgula ";" - no CSV os valores da coluna que vem são separados com ";" 
                Delimiter = ";",

                // Ignora erros caso o cabeçalho não bata 100%
                // Não trava a aplicação por conta de formatação, vamos tratar os erros depois
                HeaderValidated = null,

                // Ignora o erro se faltar algum campo, se vier nulos
                MissingFieldFound = null,

                // Ignora dados quebrados no CSV, ex: abriu aspas e não fechou
                BadDataFound = null,

                // Remove espaços extras automaticamente
                TrimOptions = TrimOptions.Trim
            }))
            {
                // Registrar mapeamento criado, CSV para DTO
                csv.Context.RegisterClassMap<ImportarPatrimonioCsvMap>();

                // Pega todas as linhas do CSv e converte para uma lista DTO
                registros = csv.GetRecords<ImportarPatrimonioCsvDto>().ToList();
            }

            // Lista de erros (para serem tratados) que deram ao importar planilha e ignoraram para cadastrar os que não deram erro
            var erros = new List<string>();

            foreach (var item in registros)
            {
                // Se não tem número de patrimônio, ignora o registro
                if(string.IsNullOrWhiteSpace(item.NumeroPatrimonio))
                {
                    continue; // Ignora e vai para o próximo
                }

                // Remove os espaços extras do número com o Trim
                string numeroPatrimonio = item.NumeroPatrimonio.Trim(); 

                if(string.IsNullOrEmpty(item.Denominacao))
                {
                    erros.Add($"Patrimônio {numeroPatrimonio} sem denominção.");
                    continue; // Não cadastrar, mas segue no loop
                }

                string denominacao = item.Denominacao.Trim();

                DateTime? dataIncorporacao  = null;

                // Usa o formato brasileiro(que vem na planilha) só pra ler
                // Depois pega o DateTime e formata
                if(!string.IsNullOrWhiteSpace(item.DataIncorporacao))
                {
                    // Primeiro converte para o formato brasileiro(pt-BR) para leitura, depois para converter no formato que o banco aceita
                    if(DateTime.TryParse(item.DataIncorporacao, new CultureInfo("pt-BR"), DateTimeStyles.None, out DateTime dataConvertida))
                    {
                        dataIncorporacao = dataConvertida;
                    }
                }

                decimal? valorAquisicao = null;

                if(!string.IsNullOrWhiteSpace(item.Valoraquisicao))
                {
                    // Remove separador de milhar e ajusta decimal para ficar no formato que o banco aceita
                    // Tudo que for ponto converte para vazio, e tudo que for ponto converte para vírgula
                    string valorTexto = item.Valoraquisicao.Replace(".", "").Replace(",", ".");

                    // TryParse - converte string para decimal
                    // NumberStyles.Any - define quais formatos de números são permitidos - any aceita qalquer número, mesmo com sinal, com espaço, etc.
                    // out decimal valorConvertido -> se der certo: cria a variável com o valor já convertido
                    if(decimal.TryParse(valorTexto, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal valorConvertido))
                    {
                        valorAquisicao = valorConvertido;
                    }

                    Validar.ValidarNumeroPatrimonio(numeroPatrimonio);
                    Validar.ValidarNome(denominacao);

                    bool patrimonioExistente = _repository.BuscarPorNumeroPatrimonio(numeroPatrimonio);

                    if (patrimonioExistente == true)
                    {
                        continue;
                    }

                    Patrimonio patrimonio = new Patrimonio
                    {
                        Denominacao = denominacao,
                        NumeroPatrimonio = numeroPatrimonio,
                        Valor = valorAquisicao,
                        Imagem = null,
                        LocalizacaoID = localizacaoSemLocal.LocalizacaoID,
                        StatusPatrimonioID = statusAtivo.StatusPatrimonioID
                    };

                    _repository.Adicionar(patrimonio);

                    LogPatrimonio log = new LogPatrimonio
                    {
                        DataTransferencia = dataIncorporacao ?? DateTime.Now,
                        TipoAlteracaoID = tipoAlteracao.TipoAlteracaoID,
                        StatusPatrimonioID = patrimonio.StatusPatrimonioID,
                        PatrimonioID = patrimonio.PatrimonioID,
                        UsuarioID = usuarioId,
                        LocalizacaoID = patrimonio.LocalizacaoID
                    };

                    _repository.AdicionarLog(log);
                }
            }
        }

        public void AtualizarStatus(Guid patrimonioId, AtualizarStatusPatrimonioDto dto)
        {
            Patrimonio patrimonioBanco = _repository.BuscarPorId(patrimonioId);

            if (patrimonioBanco == null)
            {
                throw new DomainException("Patrimônio não encontrado.");
            }

            if (!_repository.StatusPatrimonioExiste(dto.StatusPatrimonioID))
            {
                throw new DomainException("Status de patrimônio informado não existe.");
            }

            patrimonioBanco.StatusPatrimonioID = dto.StatusPatrimonioID;

            _repository.AtualizarStatus(patrimonioBanco);
        }
    }
}
