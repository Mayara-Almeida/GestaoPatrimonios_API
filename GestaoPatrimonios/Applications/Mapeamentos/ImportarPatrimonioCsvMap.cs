using CsvHelper.Configuration;
using GestaoPatrimonios.DTOs.PatrimonioDto;

namespace GestaoPatrimonios.Applications.Mapeamentos
{
    // ClassMap -> tipo um "tradutor de colunas", definine como ler o csv, relaciona a coluna da planilha com a sua propriedade na API
    // Pacote CsvHelper para importar ClassMap
    public class ImportarPatrimonioCsvMap : ClassMap<ImportarPatrimonioCsvDto>
    {
       // Definindo os mapeamentos
       public ImportarPatrimonioCsvMap()
        {
            // Map -> escolher a propriedade da DTO
            // Name -> Diz qual o nome da coluna do CSV para essa propriedade
            Map(m => m.NumeroPatrimonio).Name("N° invent.");
            Map(m => m.Denominacao).Name("Denominação do imobilizado");
            Map(m => m.DataIncorporacao).Name("Dt. incorp.");
            Map(m => m.Valoraquisicao).Name("ValAquis.");
        }
    }
}
