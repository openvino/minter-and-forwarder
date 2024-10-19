// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IToken {
    function mint(address to, uint256 amount) external;
}

contract TokenMinter is ERC2771Context, Ownable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // Mapeo para almacenar los contratos de tokens que pueden ser minteados
    mapping(address => bool) public allowedTokens;

    event TokenAdded(address tokenAddress);
    event TokenRemoved(address tokenAddress);

    // Almacenar la dirección del forwarder
    address public trustedForwarder;

    // Constructor que inicializa ERC2771Context y Ownable
    constructor(address _trustedForwarder) ERC2771Context(_trustedForwarder) Ownable() {
        trustedForwarder = _trustedForwarder;
    }

    // Nueva función para devolver el trustedForwarder
    function getTrustedForwarder() public view returns (address) {
        return trustedForwarder;
    }

    // Función para agregar un token a la lista de contratos permitidos (solo owner)
    function addToken(address tokenAddress) public onlyOwner {
        require(!allowedTokens[tokenAddress], "Token already allowed");
        allowedTokens[tokenAddress] = true;
        emit TokenAdded(tokenAddress);
    }

    // Función para remover un token de la lista de contratos permitidos (solo owner)
    function removeToken(address tokenAddress) public onlyOwner {
        require(allowedTokens[tokenAddress], "Token is not allowed");
        allowedTokens[tokenAddress] = false;
        emit TokenRemoved(tokenAddress);
    }

    // Función para mintear tokens desde los contratos permitidos
    function mint(address tokenAddress, address to, uint256 amount) public {
        require(allowedTokens[tokenAddress], "Token is not allowed for minting");

        // Verificar si el contrato está autorizado como minter en el token
        require(AccessControl(tokenAddress).hasRole(MINTER_ROLE, address(this)), "Contract is not a minter");

        // Llamar a la función mint del token
        IToken(tokenAddress).mint(to, amount);
    }

    // Sobrescribir _msgSender para reconocer el remitente original en meta-transacciones
    function _msgSender() internal view override(Context, ERC2771Context) returns (address) {
        return ERC2771Context._msgSender();
    }

    // Sobrescribir _msgData para reconocer los datos originales en meta-transacciones
    function _msgData() internal view override(Context, ERC2771Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }

    function _contextSuffixLength() internal view override(Context, ERC2771Context) returns (uint256) {
        return ERC2771Context._contextSuffixLength();
    }
}
