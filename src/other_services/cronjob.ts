import { CronJob } from 'cron';
import { exec } from 'child_process';

// Define the function to be executed when the cron job triggers
function backupTask() {
    exec(`bash ./backup.sh`, (err, stdout, stderr) => {
        if (err) {
            console.log(err);
        }
        console.log(stdout);
    });
}

// Create a new cron job with the backup task
const job = new CronJob(
    '5 * * * * *', // cronTime
    backupTask, // onTick function
    () => {
        console.log('cron job stopped');
    }, // onComplete function
    true, // start
    "Europe/Copenhagen" // timeZone
);

export default job;
