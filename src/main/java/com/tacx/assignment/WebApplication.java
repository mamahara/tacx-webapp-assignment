package com.tacx.assignment;

import io.jaegertracing.Configuration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication
public class WebApplication extends SpringBootServletInitializer {

	@Bean
	public io.opentracing.Tracer initTracer() {
		Configuration.SamplerConfiguration samplerConfig = new
				Configuration.SamplerConfiguration()
				.withType("const").withParam(1);
		return Configuration.fromEnv("tacx-assignment-webapp")
				.withSampler(samplerConfig).getTracer();
	}

	@Override
	protected SpringApplicationBuilder configure(
			SpringApplicationBuilder application) {
		return application.sources(WebApplication.class);
	}

	public static void main(String[] args) throws Exception {
		SpringApplication.run(WebApplication.class, args);
	}
}
