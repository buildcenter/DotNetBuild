using System;
using MyFoo.CSharpLib;

namespace MyFoo
{
    /// <summary>
    /// Sample class
    /// </summary>
    public static class SampleClass
    {
        /// <summary>
        /// This method always return <c>true</c>.
        /// </summary>
        public static bool GetTrue()
        {
            return true;
        }

        /// <summary>
        /// This method always return a localization text string.
        /// </summary>
        public static string GetResText()
        {
            return RS.ResText1;
        }
    }
}
