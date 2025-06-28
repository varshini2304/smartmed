const MongoDBOptions mongoDBOptions = MongoDBOptions(
  connectionString: "your_mongodb_connection_string",
  databaseName: "your_database_name",
);

class MongoDBOptions {
  final String connectionString;
  final String databaseName;

  const MongoDBOptions({
    required this.connectionString,
    required this.databaseName,
  });
}
