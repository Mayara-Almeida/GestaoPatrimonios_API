using GestaoPatrimonios.Contexts;
using GestaoPatrimonios.Domains;
using GestaoPatrimonios.Interfaces;

namespace GestaoPatrimonios.Repositores
{
    public class AreaRepository : IAreaRepository
    {
        private readonly GestaoPatrimoniosContext _context;

        public AreaRepository(GestaoPatrimoniosContext context)
        {
            _context = context;
        }

       public List<Area> Listar()
       {
            return _context.Area.OrderBy(area => area.NomeArea).ToList(); // A requisição já traz uma lista ordenada por ordem alfabética
       }

       public Area BuscarPorId(Guid areaId)
       {
            return _context.Area.Find(areaId); // Find -> Trabalha melhor com a chave primária, geralmente o id
       }

       public Area BuscarPorNome(string nomeArea) // É usado apenas para validar se o nome existe, e não para uma busca
       {
            return _context.Area.FirstOrDefault(area => area.NomeArea.ToLower() == nomeArea.ToLower()); // .ToLower() -> deixa toda a string em letras minúsculas
       }

       public void Adicionar(Area area)
        {
            _context.Area.Add(area);
            _context.SaveChanges();
        }

        public void Atualizar(Area area)
        {
            if(area == null)
            {
                return;
            }

            Area areaBanco = _context.Area.Find(area.AreaID);

            areaBanco.NomeArea = area.NomeArea;
            _context.SaveChanges();
        }
    }
}
