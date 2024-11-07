-include .env

deploy-myNft-anvil:
	@forge script script/DeployMyNft.s.sol:DeployMyNft --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

deploy-myNft-sepolia:
	@forge script script/DeployMyNft.s.sol:DeployMyNft --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --legacy  -vvvv

deploy-registry-anvil:
	@forge script script/DeployRegistry.s.sol:DeployRegistry --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

deploy-registry-sepolia:
	@forge script script/DeployRegistry.s.sol:DeployRegistry --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --legacy  -vvvv

deploy-accountImplementation-anvil:
	@forge script script/DeployAccountImplementation.s.sol:DeployAccountImplementation --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

deploy-accountImplementation-sepolia:
	@forge script script/DeployAccountImplementation.s.sol:DeployAccountImplementation --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --legacy  -vvvv