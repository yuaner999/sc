package com.task;

import org.springframework.scheduling.annotation.Scheduled;

import java.util.Map;
import java.util.concurrent.BlockingQueue;

/**
 * Created by admin on 2016/8/25.
 */
public interface CopyTaskService {
    void loadInfo(String flag);
    void runInfo(int index);
//    @Scheduled(cron = "0 24 * * * *")需要时开启
    void autoRun();
}
