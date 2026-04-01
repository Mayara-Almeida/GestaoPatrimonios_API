using System.ComponentModel.DataAnnotations;

namespace GestaoPatrimonios.DTOs.AreaDto
{
    public class CriarAreaDto
    {
        // Tratamento de erros antes da criação da variável
        // [Required(ErrorMessage = "O nome da área é obrigatório.")]
        [StringLength(50, ErrorMessage = "O nome da área deve ter no máximo 50 caracteres.")]
        public string NomeArea { get; set; } = string.Empty; // string.Empty -> null é proibido
                                                             // string? = pode ser null
                                                             // null! = "relaxa, confia que não vai entrar null!" - mas vai dar merda
    }
}
