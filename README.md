# Zsheet
SwiftUI Sheet works like a Sheet, but instead overlays the new view in a Stack allowing for matched geometry transitions and effects

## How to use

            .zSheet(item: $viewModel.presentingAsset) { asset in
                AssetTabView(selectedAsset: $viewModel.presentingAsset, assets: viewModel.assets)
            }
            
            .zSheet(isPresented: .constant(false)) {
                Text("Hi")
            }

