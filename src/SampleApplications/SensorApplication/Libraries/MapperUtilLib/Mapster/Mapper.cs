using Mapster;

namespace CSD.Util.Mappers.Mapster
{
    public class Mapper : IMapper
    {
        public D Map<D, S>(S source)
        {
            return source.Adapt<D>();
        }
    }
}
