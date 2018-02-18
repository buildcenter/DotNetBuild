using System;
using System.Linq;
using System.Collections;
using Xunit;
using MyFoo;

namespace MyFoo.Tests
{
    public class SampleClassTest
    {
		[Fact]
		public void GetTrueReturnsTrue()
		{
			Assert.True(SampleClass.GetTrue());
		}

		[Fact]
        public void GetResTextWorks() 
        {
	    	Assert.Equal("Hello world!", SampleClass.GetResText());
	    }
	}
}

