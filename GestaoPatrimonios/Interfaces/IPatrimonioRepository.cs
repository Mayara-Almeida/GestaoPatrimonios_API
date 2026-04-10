using GestaoPatrimonios.Domains;

namespace GestaoPatrimonios.Interfaces
{
    public interface IPatrimonioRepository
    {
        List<Patrimonio> Listar();
        Patrimonio BuscarPorId(Guid patrimonioId);
        bool BuscarPorNumeroPatrimonio(string numeroPatrimonio);

        Localizacao LocalizacaoExiste(string nomeLocalizacao);
        bool StatusPatrimonioExiste(Guid statusPatrimonioId);

        void Adicionar(Patrimonio patrimonio);
        void AtualizarStatus(Patrimonio patrimonio);
        void AdicionarLog(LogPatrimonio logPatrimonio);

        Localizacao BuscarLocalizacaoPorNome(string nomeLocalizacao);
        StatusPatrimonio BuscarStatusPatrimonioPorNome(string nomeStatus);
        TipoAlteracao BuscarTipoAlteracaoPorNome(string nomeTipo);
    }
}
