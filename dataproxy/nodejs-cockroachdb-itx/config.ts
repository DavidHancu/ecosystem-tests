export const config = {
  globalTimeout: 900_000_000,
  'lots-of-activities': {
    amount: 10, // Amount of read and writes inside a transaction
  },
  'long-running': {
    transactionDelay: 6000, // How long to delay the transaction
  },
  'batch-itx': {
    batchAmount: 100, // How many records to create and update
    transactionDelay: 200, // How long to delay the transaction
  },
  concurrent: {
    amount: 10, // How many concurrent to run at once
  },
  'burst-load': {
    bursts: 1, // How many bursts to perform
    children: 5, // How many ITX to do in a burst
    backoff: 1000, // How long to wait in-between each burst
  },
}