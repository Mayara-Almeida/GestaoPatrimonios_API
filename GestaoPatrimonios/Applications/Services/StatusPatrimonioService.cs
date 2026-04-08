using GestaoPatrimonios.Applications.Regras;
using GestaoPatrimonios.Domains;
using GestaoPatrimonios.DTOs.StatusPatrimonioDto;
using GestaoPatrimonios.Exceptions;
using GestaoPatrimonios.Interfaces;

namespace GestaoPatrimonios.Applications.Services
{
    public class StatusPatrimonioService
    {
        private readonly IStatusPatrimonioRepository _repository;

        public StatusPatrimonioService(IStatusPatrimonioRepository repository)
        {
            _repository = repository;
        }

        public List<ListarStatusPatrimonioDto> Listar()
        {
            List<StatusPatrimonio> statusPatrimonios = _repository.Listar();

            List<ListarStatusPatrimonioDto> statusPatrimonioDto = statusPatrimonios
                .Select(status => new ListarStatusPatrimonioDto
                {
                    StatusPatrimonioId = status.StatusPatrimonioID,
                    NomeStatus = status.NomeStatus
                }).ToList();

            return statusPatrimonioDto;
        }

        public ListarStatusPatrimonioDto BuscarPorId(Guid statusPatrimonioId)
        {
            StatusPatrimonio statusPatrimonio = _repository.BuscarPorId(statusPatrimonioId);

            if(statusPatrimonio == null)
            {
                throw new DomainException("Status de patrimônio não encontrado.");
            }

            ListarStatusPatrimonioDto statusPatrimonioDto = new ListarStatusPatrimonioDto
            {
                StatusPatrimonioId = statusPatrimonio.StatusPatrimonioID,
                NomeStatus = statusPatrimonio.NomeStatus
            };

            return statusPatrimonioDto;
        }

        public void Adicionar(CriarStatusPatrimonioDto dto)
        {
            Validar.ValidarNome(dto.NomeStatus);

            StatusPatrimonio statusPatrimonioExistente = _repository.BuscarPorNome(dto.NomeStatus);

            if(statusPatrimonioExistente != null)
            {
                throw new DomainException("Já existe um status de patrimônio cadastrado com esse nome.");
            }

            StatusPatrimonio statusPatrimonio = new StatusPatrimonio
            {
                NomeStatus = dto.NomeStatus
            };

            _repository.Adicionar(statusPatrimonio);
        }

        public void Atualizar(Guid statusPatrimonioId, CriarStatusPatrimonioDto dto)
        {
            Validar.ValidarNome(dto.NomeStatus);

            StatusPatrimonio statusBanco = _repository.BuscarPorId(statusPatrimonioId);

            if(statusBanco == null)
            {
                throw new DomainException("Status de patrimônio não encontrado.");
            }

            StatusPatrimonio statusExistente = _repository.BuscarPorNome(dto.NomeStatus);

            if (statusExistente != null && statusExistente.StatusPatrimonioID != statusPatrimonioId)
            {
                throw new DomainException("Já existe um status de patrimônio cadastrado com esse nome.");
            }

            statusBanco.NomeStatus = dto.NomeStatus;
            _repository.Atualizar(statusBanco);
        }
    }
}
