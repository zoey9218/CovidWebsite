package com.CSCI4050.TermProject.CovidWebsite;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication // (exclude = {JndiConnectionFactoryAutoConfiguration.class,
						// DataSourceAutoConfiguration.class,
						// HibernateJpaAutoConfiguration.class, JpaRepositoriesAutoConfiguration.class,
						// DataSourceTransactionManagerAutoConfiguration.class})

public class CovidWebsiteApplication {

	public static void main(String[] args) {
		SpringApplication.run(CovidWebsiteApplication.class, args);
	}

}
