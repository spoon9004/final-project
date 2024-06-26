package com.javarush.jira.common.internal.config;

import liquibase.Liquibase;
import liquibase.database.jvm.JdbcConnection;
import liquibase.resource.ClassLoaderResourceAccessor;
import lombok.SneakyThrows;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {

    @Bean
    @Profile("prod")
    @Primary
    public DataSource postgresDataSource() {
        return DataSourceBuilder.create()
                .url("jdbc:postgresql://localhost:5433/jira")
                .username(System.getenv("DB_USERNAME"))
                .password(System.getenv("DB_PASSWORD"))
                .driverClassName("org.postgresql.Driver")
                .build();
    }

    @Profile("test")
    @Bean
    public DataSource h2DataSource() {
        DataSource dataSource = DataSourceBuilder.create()
                .url("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE")
                .username("sa")
                .password("")
                .driverClassName("org.h2.Driver")
                .build();
//        Liquibase liquibase = new Liquibase("/db/changelog-test.sql", new ClassLoaderResourceAccessor(), new JdbcConnection(dataSource.getConnection()));
//        // Запуск Liquibase с использованием H2 DataSource

        return dataSource;
    }



}