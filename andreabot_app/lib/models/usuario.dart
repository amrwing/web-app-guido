class Usuario {
  String usuario;
  String role;
  String? password;
  String? token;
  String? _apellidoPaterno;
  String? _apellidoMaterno;
  String? _nombre;
  String? _domicilio;
  String? _noExt;
  String? _noInt;
  String? _fraccionamiento;
  String? _distrito;
  String? _seccion;
  String? _fechaNacimiento;
  String? _telefono;
  String? _celular;
  String? _perfilDeFacebook;
  String? _claveDeElector;
  String? _idLider;
  String? _origen;

  Usuario(
      {required this.usuario, this.password, required this.role, this.token});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuario: json["usuario"],
        role: json['data']["rol"],
        token: json['data']['token'],
      );
  set setApellidoPaterno(String dato) => _apellidoPaterno = dato;
  set setApellidoMaterno(String dato) => _apellidoMaterno = dato;
  set setNombre(String dato) => _nombre = dato;
  set setDomicilio(String dato) => _domicilio = dato;
  set setNoExt(String dato) => _noExt = dato;
  set setNoInt(String dato) => _noInt = dato;
  set setFraccionamiento(String dato) => _fraccionamiento = dato;
  set setDistrito(String dato) => _distrito = dato;
  set setSeccion(String dato) => _seccion = dato;
  set setFechaNacimiento(String dato) => _fechaNacimiento = dato;
  set setTelefono(String dato) => _telefono = dato;
  set setCelular(String dato) => _celular = dato;
  set setPerfilDeFacebook(String dato) => _perfilDeFacebook = dato;
  set setClaveDeElector(String dato) => _claveDeElector = dato;
  set setIdLider(String dato) => _idLider = dato;
  set setOrigen(String dato) => _origen = dato;

  get getApellidoPaterno => _apellidoPaterno;
  get getApellidoMaterno => _apellidoMaterno;
  get getNombre => _nombre;
  get getDomicilio => _domicilio;
  get getNoExt => _noExt;
  get getNoInt => _noInt;
  get getFraccionamiento => _fraccionamiento;
  get getDistrito => _distrito;
  get getSeccion => _seccion;
  get getFechaNacimiento => _fechaNacimiento;
  get getTelefono => _telefono;
  get getCelular => _celular;
  get getPerfilDeFacebook => _perfilDeFacebook;
  get getClaveDeElector => _claveDeElector;
  get getLider => _idLider;
  get getOrigen => _origen;
}
