using System;
using System.Linq;
using System.Collections;
using Xunit;
using MyFoo;

namespace MyFoo.Tests
{
    public class SampleResTest
    {
		[Fact]
        public void GetRes1TextWorks() 
        {
	    	Assert.Equal("Hello world!", SampleRes.GetResText1());
	    }

		[Fact]
        public void GetRes2TextWorks() 
        {
	    	Assert.Equal("Hello world 2!", SampleRes.GetResText2());
	    }

		[Fact]
        public void GetRes3TextWorks() 
        {
	    	Assert.Equal("Hello world 3!", SampleRes.GetResText3());
	    }
	}
}

