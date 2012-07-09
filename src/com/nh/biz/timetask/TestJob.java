package com.nh.biz.timetask;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class TestJob  extends QuartzJobBean{

    private int timeout;
	  
	  /**
	   * Setter called after the ExampleJob is instantiated
	   * with the value from the JobDetailBean (5)
	   */ 
	public void setTimeout(int timeout) {
	  this.timeout = timeout;
	}

	protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {
		System.out.println("executeInternal==========");
	}

}
