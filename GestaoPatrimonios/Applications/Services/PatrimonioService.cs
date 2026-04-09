using GestaoPatrimonios.Applications.Regras;
using GestaoPatrimonios.Domains;
using GestaoPatrimonios.DTOs.PatrimonioDto;
using GestaoPatrimonios.Exceptions;
using GestaoPatrimonios.Interfaces;
using System.Drawing;
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

        public ListarPatrimonioDto BuscarPorNumeroPatrimonio(string numeroPatrimonio, Guid? patrimonioId = null)
        {
            Patrimonio patrimonio = _repository.BuscarPorNumeroPatrimonio(numeroPatrimonio);

            if (patrimonio == null)
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

        public void Adicionar(CriarPatrimonioDto dto)
        {
            Validar.ValidarDenominacao(dto.Denominacao);
            Validar.ValidarNumeroPatrimonio(dto.NumeroPatrimonio);

            if (!_repository.LocalizacaoExiste(dto.LocalizacaoID))
            {
                throw new DomainException("Localização informada não existe.");
            }

            if (!_repository.StatusPatrimonioExiste(dto.StatusPatrimonioID))
            {
                throw new DomainException("Status de patrimônio informado não existe.");
            }

            Patrimonio patrimonioExistente = _repository.BuscarPorNumeroPatrimonio(dto.NumeroPatrimonio);

            if(patrimonioExistente != null )
            {
                throw new DomainException("Já existe um patrimônio com esse número.");
            }

            Patrimonio patrimonio = new Patrimonio
            {
                Denominacao = dto.Denominacao,
                NumeroPatrimonio = dto.NumeroPatrimonio,
                Valor = dto.Valor,
                Imagem = dto.Imagem,
                LocalizacaoID = dto.LocalizacaoID,
                StatusPatrimonioID = dto.StatusPatrimonioID
            };

            _repository.Adicionar(patrimonio);
        }

        public void Atualizar(Guid patrimonioId, CriarPatrimonioDto dto)
        {
            Validar.ValidarDenominacao(dto.Denominacao);
            Validar.ValidarNumeroPatrimonio(dto.NumeroPatrimonio);

            Patrimonio patrimonioBanco = _repository.BuscarPorId(patrimonioId);

            if(patrimonioBanco == null)
            {
                throw new DomainException("Patrimônio não encontrado.");
            }

            if (!_repository.LocalizacaoExiste(dto.LocalizacaoID))
            {
                throw new DomainException("Localização informada não existe.");
            }

            if (!_repository.StatusPatrimonioExiste(dto.StatusPatrimonioID))
            {
                throw new DomainException("Status de patrimônio informado não existe.");
            }

            Patrimonio patrimonioExistente = _repository.BuscarPorNumeroPatrimonio(dto.NumeroPatrimonio);

            if (patrimonioExistente != null)
            {
                throw new DomainException("Já existe um patrimônio com esse número.");
            }

            patrimonioBanco.Denominacao = dto.Denominacao;
            patrimonioBanco.NumeroPatrimonio = dto.NumeroPatrimonio;
            patrimonioBanco.Valor = dto.Valor;
            patrimonioBanco.Imagem = dto.Imagem;
            patrimonioBanco.LocalizacaoID = dto.LocalizacaoID;
            patrimonioBanco.StatusPatrimonioID = dto.StatusPatrimonioID;

            _repository.Atualizar(patrimonioBanco);
        }

        public void AtualizarStatus(Guid patrimonioId, Guid statusPatrimonioId)
        {
            Patrimonio patrimonioBanco = _repository.BuscarPorId(patrimonioId);

            if(patrimonioBanco == null)
            {
                throw new DomainException("Patrimônio não encontrado.");
            }

            if (!_repository.StatusPatrimonioExiste(statusPatrimonioId))
            {
                throw new DomainException("Status de patrimônio informado não existe.");
            }

            patrimonioBanco.StatusPatrimonioID = statusPatrimonioId;
            _repository.AtualizarStatus(patrimonioBanco);
        }
    }
}
