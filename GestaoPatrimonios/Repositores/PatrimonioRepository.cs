using GestaoPatrimonios.Contexts;
using GestaoPatrimonios.Domains;
using GestaoPatrimonios.Interfaces;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;

namespace GestaoPatrimonios.Repositores
{
    public class PatrimonioRepository : IPatrimonioRepository
    {
        private readonly GestaoPatrimoniosContext _context;

        public PatrimonioRepository(GestaoPatrimoniosContext context)
        {
            _context = context;
        }

        public List<Patrimonio> Listar()
        {
            return _context.Patrimonio.OrderBy(patrimonio => patrimonio.Denominacao).ToList();
        }

        public Patrimonio BuscarPorId(Guid patrimonioId)
        {
            return _context.Patrimonio.Find(patrimonioId);
        }

        public bool BuscarPorNumeroPatrimonio(string numeroPatrimonio)
        {
            return _context.Patrimonio.Any(patrimonio => patrimonio.NumeroPatrimonio == numeroPatrimonio);
        }
        public bool StatusPatrimonioExiste(Guid statusPatrimonioId)
        {
            return _context.StatusPatrimonio.Any(status => status.StatusPatrimonioID == statusPatrimonioId);
        }

        public Localizacao LocalizacaoExiste(string nomeLocalizacao)
        {
            return _context.Localizacao.FirstOrDefault(localizacao => localizacao.NomeLocal.ToLower() == nomeLocalizacao.ToLower());
        }

        public StatusPatrimonio BuscarStatusPatrimonioPorNome(string nomeStatus)
        {
            return _context.StatusPatrimonio.FirstOrDefault(status => status.NomeStatus.ToLower() == nomeStatus.ToLower());
        }

        public TipoAlteracao BuscarTipoAlteracaoPorNome(string nomeTipo)
        {
            return _context.TipoAlteracao.FirstOrDefault(tipo => tipo.NomeTipo.ToLower() == nomeTipo.ToLower());
        }

        public Localizacao BuscarLocalizacaoPorNome(string nomeLocalizacao)
        {
            return _context.Localizacao.FirstOrDefault(localizacao => localizacao.NomeLocal.ToLower() == nomeLocalizacao.ToLower());
        }

        public void Adicionar(Patrimonio patrimonio)
        {
            _context.Patrimonio.Add(patrimonio);
            _context.SaveChanges();
        }

        public void AtualizarStatus(Patrimonio patrimonio)
        {
            if (patrimonio == null)
            {
                return;
            }

            Patrimonio patrimonioBanco = _context.Patrimonio.Find(patrimonio.PatrimonioID);

            if (patrimonioBanco == null)
            {
                return;
            }

            patrimonioBanco.StatusPatrimonioID = patrimonio.StatusPatrimonioID;

            _context.SaveChanges();
        }

        public void AdicionarLog(LogPatrimonio logPatrimonio)
        {
            _context.LogPatrimonio.Add(logPatrimonio);
            _context.SaveChanges();
        }
    }
}
