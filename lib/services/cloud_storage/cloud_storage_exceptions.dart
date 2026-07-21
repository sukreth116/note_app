class CloudStorageExceptions implements Exception {
  const CloudStorageExceptions();
}

// C in crud
class CouldNotCreateNoteException extends CloudStorageExceptions{}

// R in CRUD
class CouldNotGetAllNoteException extends CloudStorageExceptions{}

// U in CRUD
class CouldNoteUpdateNoteException extends CloudStorageExceptions{}

// D in CRUD 
class CouldNoteDeleteNoteException extends CloudStorageExceptions{}
