using GestaoPatrimonios.Applications.Services;
using GestaoPatrimonios.DTOs.AutenticacaoDto;
using GestaoPatrimonios.Exceptions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace GestaoPatrimonios.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AutenticacaoController : ControllerBase
    {
        private readonly AutenticacaoService _service;

        public AutenticacaoController(AutenticacaoService service)
        {
            _service = service;
        }

        [HttpPost("login")]
        public ActionResult<TokenDto> Login(LoginDto loginDto)
        {
            try
            {
                TokenDto token = _service.Login(loginDto);
                return Ok(token);
            }
            catch (DomainException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Authorize]
        [HttpPatch("trocar-senha")] // Faz alterações de coisas específicas (nesse caso somente a senha)
        public ActionResult TrocarPrimeiraSenha(TrocarPrimeiraSenhaDto dto)
        {
            try
            {
                string usuarioIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value; // Pegar informações do usuário

                if (string.IsNullOrWhiteSpace(usuarioIdClaim))
                {
                    return Unauthorized("Usuário não autenticado.");
                }

                Guid usuarioId = Guid.Parse(usuarioIdClaim); //Convertendo string que vem do Jwt para Guid

                _service.TrocarPrimeiraSenha(usuarioId, dto);

                return NoContent();
            }

            catch (DomainException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
