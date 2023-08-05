import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:web3dart/web3dart.dart';

final LocalStorage storage = LocalStorage('data');

class Contract extends ChangeNotifier {
  final String _rpcUrl = "https://rpc.sepolia.dev";

  late Web3Client _client;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;
  late DeployedContract _contract;

  late ContractFunction _purchaseTicket;

  late String deployedName;
  Contract() {
    initialSetup();
  }

  initialSetup() async {
    var httpClient = Client();
    var ethClient = Web3Client(_rpcUrl, httpClient);
    _client = ethClient;

    var rng = Random.secure();
    Credentials credentials = EthPrivateKey.createRandom(rng);
    _credentials = credentials;
    // var address = credentials.address;
    // EtherAmount balance = await ethClient.getBalance(address);
    await getContractAddress();
    await getDeployedContract();
  }

  getContractAddress() async {
    String abiStringFile = await rootBundle.loadString("abi.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi);

    _contractAddress =
        EthereumAddress.fromHex("0x452eA15a790320f3fD7Dc6638c84f0A2589ed235");
  }

  Future<void> getDeployedContract() async {
    _contract = await DeployedContract(
        ContractAbi.fromJson(_abiCode, "abi"), _contractAddress);
    print(_contract.address);
    _purchaseTicket = _contract.function("purchaseTicket");
  }

  Future<bool> transferTicket(BigInt event_id) async {
    try {
      print("object");
      await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract,
              function: _purchaseTicket,
              parameters: [event_id]));
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
