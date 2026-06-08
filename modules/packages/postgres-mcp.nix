{ lib, python312Packages, fetchFromGitHub, }:
python312Packages.buildPythonApplication {
  pname = "postgres-mcp";
  version = "0.3.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "crystaldba";
    repo = "postgres-mcp";
    rev = "7179ab0336396f819e23b0b012a9c284be10fac3";
    hash = "sha256-VCU7qVPbYyBBkLwtmNf+I0XxGzY4Qd7JFHEwbI8eU+I=";
  };

  build-system = [ python312Packages.hatchling ];

  # psycopg-pool defaults to 30s timeout for acquiring connections, causing MCP initialize
  # to time out in Claude Code. Reduce to 5s so the server starts quickly even when DB
  # is temporarily unreachable.
  postPatch = ''
    substituteInPlace src/postgres_mcp/sql/sql_driver.py \
      --replace-fail \
        "min_size=1," \
        "min_size=1, timeout=5.0,"
  '';

  dependencies = with python312Packages; [
    mcp
    psycopg
    psycopg-pool
    pglast
    humanize
    attrs
    instructor
  ];

  # postgres-mcp pins pglast==7.2.0 but nixpkgs ships 7.11 which is compatible
  pythonRelaxDeps = [ "pglast" ];

  meta = {
    description = "PostgreSQL MCP server with tuning and analysis capabilities";
    homepage = "https://github.com/crystaldba/postgres-mcp";
    license = lib.licenses.mit;
    mainProgram = "postgres-mcp";
  };
}
