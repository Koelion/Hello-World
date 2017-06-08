using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Migrations
{
    public interface IMigrator
    {
        void MigrateUp();
        void MigrateDown(long version);
        void Rollback(int steps);
        void RollbackToVersion(long version);
    }
}
