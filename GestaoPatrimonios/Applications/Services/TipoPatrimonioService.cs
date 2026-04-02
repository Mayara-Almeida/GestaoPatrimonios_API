using GestaoPatrimonios.Applications.Regras;
using GestaoPatrimonios.Domains;
using GestaoPatrimonios.DTOs.TipoPatrimonioDto;
using GestaoPatrimonios.Exceptions;
using GestaoPatrimonios.Interfaces;
using Microsoft.Identity.Client;

namespace GestaoPatrimonios.Applications.Services
{
    public class TipoPatrimonioService
    {
        private readonly ITipoPatrimonioRepository _repository;

        public TipoPatrimonioService (ITipoPatrimonioRepository repository)
        {
            _repository = repository;
        }

        public List<ListarTipoPatrimonioDto> Listar()
        {
            List<TipoPatrimonio> tiposPatrimonio = _repository.Listar();

            List<ListarTipoPatrimonioDto> tipoPatrimonioDto = tiposPatrimonio.Select(tipoPatrimonio => new ListarTipoPatrimonioDto
            {
                TipoPatrimonioID = tipoPatrimonio.TipoPatrimonioID,
                NomeTipo = tipoPatrimonio.NomeTipo
            }).ToList();

            return tipoPatrimonioDto;
        }

        public ListarTipoPatrimonioDto BuscarPorId(Guid tipoPatrimonioId)
        {
            TipoPatrimonio tipoPatrimonio = _repository.BuscarPorId(tipoPatrimonioId);

            if(tipoPatrimonio == null)
            {
                throw new DomainException("Tipo de patrimônio não encontrado.");
            }

            ListarTipoPatrimonioDto tipoPatrimonioDto = new ListarTipoPatrimonioDto
            {
                TipoPatrimonioID = tipoPatrimonio.TipoPatrimonioID,
                NomeTipo = tipoPatrimonio.NomeTipo
            };

            return tipoPatrimonioDto;
        }

        public void Adicionar (CriarTipoPatrimonioDto dto)
        {
            Validar.ValidarNome(dto.NomeTipo);

            TipoPatrimonio tipoPatrimonioExistente = _repository.BuscarPorNome(dto.NomeTipo);

            if(tipoPatrimonioExistente != null)
            {
                throw new DomainException("Já existe um tipo de patrimônio com esse nome.");
            }

            TipoPatrimonio tipoPatrimonio = new TipoPatrimonio
            {
                NomeTipo = dto.NomeTipo,
            };

            _repository.Adicionar(tipoPatrimonio);
        }

        public void Atualizar(Guid tipoPatrimonioId, CriarTipoPatrimonioDto dto)
        {
            Validar.ValidarNome(dto.NomeTipo);

            TipoPatrimonio tipoPatrimonioBanco = _repository.BuscarPorId(tipoPatrimonioId);

            if(tipoPatrimonioBanco == null)
            {
                throw new DomainException("Tipo de patrimônio não encontrado.");
            }

            TipoPatrimonio tipoPatrimonioExistente = _repository.BuscarPorNome(dto.NomeTipo);

            if(tipoPatrimonioExistente != null && tipoPatrimonioExistente.TipoPatrimonioID != tipoPatrimonioId)
            {
                throw new DomainException("Já existe um tipo de patrimônio com esse nome.");
            }

            tipoPatrimonioBanco.NomeTipo = dto.NomeTipo;
            _repository.Atualizar(tipoPatrimonioBanco);
        }
    }
}
