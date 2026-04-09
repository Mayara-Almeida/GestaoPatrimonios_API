using GestaoPatrimonios.Applications.Services;
using GestaoPatrimonios.DTOs.PatrimonioDto;
using GestaoPatrimonios.Exceptions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace GestaoPatrimonios.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatrimonioController : ControllerBase
    {
        private readonly PatrimonioService _service;

        public PatrimonioController(PatrimonioService service)
        {
            _service = service;
        }

        [HttpGet]
        public ActionResult<List<ListarPatrimonioDto>> Listar()
        {
            List<ListarPatrimonioDto> patrimonios = _service.Listar();
            return Ok(patrimonios);
        }

        [HttpGet("{id}")]
        public ActionResult<ListarPatrimonioDto> BuscarPorId(Guid id)
        {
            try
            {
                ListarPatrimonioDto patrimonio = _service.BuscarPorId(id);
                return Ok(patrimonio);
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("numero/{numeroPatrimonio}")]
        public ActionResult<ListarPatrimonioDto> BuscarPorNumeroPatrimonio(string numeroPatrimonio)
        {
            try
            {
                ListarPatrimonioDto patrimonio = _service.BuscarPorNumeroPatrimonio(numeroPatrimonio);
                return Ok(patrimonio);
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpPost]
        public ActionResult Adicionar(CriarPatrimonioDto dto)
        {
            try
            {
                _service.Adicionar(dto);
                return StatusCode(201);
            }
            catch (DomainException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("{id}")]
        public ActionResult Atualizar(Guid id, CriarPatrimonioDto dto)
        {
            try
            {
                _service.Atualizar(id, dto);
                return NoContent();
            }
            catch (DomainException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("{id}/status")]
        public ActionResult AtualizarStatus(Guid id, Guid statusPatrimonioId)
        {
            try
            {
                _service.AtualizarStatus(id, statusPatrimonioId);
                return NoContent();
            }
            catch (DomainException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
