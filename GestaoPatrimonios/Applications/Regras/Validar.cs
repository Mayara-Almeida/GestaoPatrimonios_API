using GestaoPatrimonios.Exceptions;

namespace GestaoPatrimonios.Applications.Regras
{
    public class Validar
    {
        public static void ValidarNome(string nome)
        {
            if (string.IsNullOrWhiteSpace(nome))
            {
                throw new DomainException("Nome é obrigatório.");
            }
        }

        public static void ValidarEstado(string estado)
        {
            if (string.IsNullOrWhiteSpace(estado))
            {
                throw new DomainException("Estado é obrigatório.");
            }
        }

        public static void ValidarLogradouro(string estado)
        {
            if (string.IsNullOrWhiteSpace(estado))
            {
                throw new DomainException("Logradouro é obrigatório.");
            }
        }

        public static void ValidarDenominacao(string denominacao)
        {
            if (string.IsNullOrWhiteSpace(denominacao))
            {
                throw new DomainException("Denominação é obrigatório.");
            }
        }

        public static void ValidarNumeroPatrimonio(string numeroPatrimonio)
        {
            if (string.IsNullOrWhiteSpace(numeroPatrimonio))
            {
                throw new DomainException("Número de patrimônio é obrigatório.");
            }
        }
    }
}
