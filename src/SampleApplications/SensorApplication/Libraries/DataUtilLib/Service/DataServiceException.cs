using System;

namespace CSD.Util.Data.Service
{
    public class DataServiceException : Exception
    {
        public DataServiceException(string message, Exception innerException)
            : base(message, innerException)
        { }

        public override string Message
        {
            get
            {
                var msg = InnerException != null ? ", InnerException Message:" + InnerException.Message : "";

                return $"Message:{base.Message}{msg}";
            }
        }
    }
}
