using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace CustomExceptions {
    public class MyException : Exception {
        public MyException(string message)
            : base(message) {
        }
    }
}