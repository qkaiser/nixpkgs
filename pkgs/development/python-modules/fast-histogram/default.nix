{
  lib,
  buildPythonPackage,
  pytestCheckHook,
  fetchFromGitHub,
  python,
  pythonOlder,
  setuptools,
  setuptools-scm,
  numpy,
  wheel,
  hypothesis,
  pytest-cov-stub,
}:

buildPythonPackage rec {
  pname = "fast-histogram";
  version = "0.14";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "astrofrog";
    repo = pname;
    tag = "v${version}";
    sha256 = "sha256-vIzDDzz6e7PXArHdZdSSgShuTjy3niVdGtXqgmyJl1w=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
    wheel
  ];

  propagatedBuildInputs = [ numpy ];

  nativeCheckInputs = [
    pytestCheckHook
    hypothesis
    pytest-cov-stub
  ];

  pytestFlagsArray = [ "${builtins.placeholder "out"}/${python.sitePackages}" ];

  pythonImportsCheck = [ "fast_histogram" ];

  meta = with lib; {
    homepage = "https://github.com/astrofrog/fast-histogram";
    description = "Fast 1D and 2D histogram functions in Python";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ifurther ];
  };
}
