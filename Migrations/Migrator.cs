namespace Migrations
{
    using FluentMigrator;
    using FluentMigrator.Runner;
    using FluentMigrator.Runner.Announcers;
    using FluentMigrator.Runner.Initialization;
    using FluentMigrator.Runner.Processors;
    using FluentMigrator.Runner.Processors.SqlServer;
    using System.Configuration;
    using System.Reflection;
    using System;

    public class Migrator : IMigrator
    {
        private SqlServer2014ProcessorFactory _factory;
        private Announcer _announcer;
        private Assembly _assembly;
        private ProcessorOptions _options;
        private string _connectionString;
        private IRunnerContext _migrationContext;

        public Migrator()
        {
            _connectionString = ConfigurationManager.AppSettings["ConnectionString"];

            _factory = new SqlServer2014ProcessorFactory();

            _announcer = new TextWriterAnnouncer(s => System.Diagnostics.Debug.WriteLine(s));
            _announcer.ShowSql = true;

            _assembly = Assembly.GetExecutingAssembly();
            _migrationContext = new RunnerContext(_announcer);

            _options = new ProcessorOptions
            {
                PreviewOnly = false,
                Timeout = 60
            };
        }

        public void MigrateUp()
        {
            using (IMigrationProcessor processor = _factory.Create(_connectionString, _announcer, _options))
            {
                var runner = new MigrationRunner(_assembly, _migrationContext, processor);
                runner.MigrateUp(true);
            }
        }

        public void MigrateUp(long version)
        {
            using (IMigrationProcessor processor = _factory.Create(_connectionString, _announcer, _options))
            {
                var runner = new MigrationRunner(_assembly, _migrationContext, processor);
                runner.MigrateUp(version, true);
            }
        }

        public void MigrateDown(long version = 0)
        {
            using (IMigrationProcessor processor = _factory.Create(_connectionString, _announcer, _options))
            {
                var runner = new MigrationRunner(_assembly, _migrationContext, processor);
                runner.MigrateDown(version, true);
            }
        }

        public void Rollback(int steps = 1)
        {
            using (IMigrationProcessor processor = _factory.Create(_connectionString, _announcer, _options))
            {
                var runner = new MigrationRunner(_assembly, _migrationContext, processor);
                runner.Rollback(steps, true);
            }
        }

        public void RollbackToVersion(long version)
        {
            using (IMigrationProcessor processor = _factory.Create(_connectionString, _announcer, _options))
            {
                var runner = new MigrationRunner(_assembly, _migrationContext, processor);
                runner.RollbackToVersion(version, true);
            }
        }
    }
}
