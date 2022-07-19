module.exports = function() {
    return {
        flywayArgs: {
            url: 'jdbc:postgresql://localhost/banking',
            schemas: 'public',
            locations: 'filesystem:scripts',
            user: 'admin',
            password: 'admin',
            sqlMigrationSuffixes: '.sql',
            baselineOnMigrate: true,
        },
    };
};