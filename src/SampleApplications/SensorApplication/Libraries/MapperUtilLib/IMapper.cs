namespace CSD.Util.Mappers
{
    public interface IMapper
    {
        D Map<D, S>(S source);
    }
}
