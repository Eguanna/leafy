package com.devwiki.leafy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(
	scanBasePackages = "com.devwiki.leafy"
)
public class LeafyApplication {

	public static void main(String[] args) {
		SpringApplication.run(LeafyApplication.class, args);
	}

}
