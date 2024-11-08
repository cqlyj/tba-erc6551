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

mint-myNft-anvil:
	@forge script script/MyNftInteractions.s.sol:MintMyNft --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

createAccountAndTransfer-anvil:
	@forge script script/RegistryInteractions.s.sol:CreateAccount --rpc-url $(ANVIL_RPC_URL) --private-keys $(ANVIL_PRIVATE_KEY) --private-keys ${ANVIL_PRIVATE_KEY_2} --sender ${ANVIL_SENDER}  --broadcast -vvvv

walk-through: deploy-myNft-anvil deploy-registry-anvil deploy-accountImplementation-anvil mint-myNft-anvil createAccountAndTransfer-anvil