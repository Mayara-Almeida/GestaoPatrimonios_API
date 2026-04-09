using System.Security.Cryptography;

namespace GestaoPatrimonios.Applications.Autenticacao
{
    public class CriptografiaUsuario
    {
        // Transformar senha em hash
        public static byte[] CriptografarSenha(string senha)
        {
            SHA256 sha256 = SHA256.Create();
            byte[] bytesSenha = System.Text.Encoding.UTF8.GetBytes(senha);
            byte[] senhaCriptografada = sha256.ComputeHash(bytesSenha);

            return senhaCriptografada;
        }
    }
}
