namespace CSD.Util.Data.Repository
{
    public interface IEntity<ID>
    {
        public ID Id { get; set; }
    }
}
