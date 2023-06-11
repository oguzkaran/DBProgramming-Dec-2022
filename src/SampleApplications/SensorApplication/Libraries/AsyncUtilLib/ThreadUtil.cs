using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace CSD.Util.Async
{
    public class ThreadUtil
    {
        public static Thread CreateThread(ParameterizedThreadStart threadStart, bool isBackground = true)
        {
            var thread = new Thread(threadStart);

            thread.IsBackground = isBackground;

            return thread;
        }

        public static Thread CreateThread(ThreadStart threadStart, bool isBackground = true)
        {
            var thread = new Thread(threadStart);

            thread.IsBackground = isBackground;

            return thread;
        }
    }
}
