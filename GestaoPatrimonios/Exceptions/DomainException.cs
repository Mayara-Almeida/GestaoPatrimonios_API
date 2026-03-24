namespace GestaoPatrimonios.Exceptions
{
    public class DomainException : Exception
    {
        public DomainException(string Mensagem) : base(Mensagem) { }
    }
}
