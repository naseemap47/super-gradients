# Fails at torch.compile (Investigate needed)
coco2017_ppyoloe_s:
	python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=coco2017_ppyoloe_s_compile_enabled multi_gpu=Off num_gpus=1
	python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=coco2017_ppyoloe_s_compile_disabled multi_gpu=Off num_gpus=1

# Fails at torch.compile (Probably could be fixed by rewriting our forward implementation to not using hooks)
# RuntimeError: Failed running call_module getattr_self_backbone_multi_output_backbone__modules__0___features___14___conv_2(*(FakeTensor(FakeTensor(..., device='meta', size=(32, 576, 20, 20),
#  File "/home/eugene.khvedchenia/super-gradients/src/super_gradients/training/utils/module_utils.py", line 61, in save_output_hook
#    self._outputs_lists[input[0].device].append(output) <---- LOOOKS SUS!!!!!
#KeyError: device(type='cuda', index=0)
coco2017_ssd_lite_mobilenet_v2:
	python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=coco2017_ssd_lite_mobilenet_v2_compile_enabled multi_gpu=Off num_gpus=1
	python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=coco2017_ssd_lite_mobilenet_v2_compile_disabled multi_gpu=Off num_gpus=1

# Crashes at first forward attempt with CUDA error (misaligned address) (Investigate needed)
coco2017_yolox:
	python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=coco2017_yolox_compile_enabled multi_gpu=Off num_gpus=1
	python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=coco2017_yolox_compile_disabled multi_gpu=Off num_gpus=1

# Works
# Training   batch time reduction - 25% faster
# Validation batch time improvement - 36% faster
# Training   epoch time reduction - 25% faster
# Validation epoch time improvement -  faster
imagenet_resnet50:
	CUDA_VISIBLE_DEVICES=0 python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=imagenet_resnet50_compile_enabled multi_gpu=Off num_gpus=1 &
	CUDA_VISIBLE_DEVICES=1 python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=imagenet_resnet50_compile_disabled multi_gpu=Off num_gpus=1 &

# Works
# Training   batch time reduction - 19,7% faster
# Validation batch time improvement - 9.3% faster
# Training   epoch time reduction - 16,5% faster
# Validation epoch time improvement - 5.4% faster
cityscapes_ddrnet:
	CUDA_VISIBLE_DEVICES=2 python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=cityscapes_ddrnet_compile_enabled multi_gpu=Off num_gpus=1 &
	CUDA_VISIBLE_DEVICES=3 python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=cityscapes_ddrnet_compile_disabled multi_gpu=Off num_gpus=1 &

cityscapes_stdc_seg50:
	CUDA_VISIBLE_DEVICES=4 python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=cityscapes_stdc_seg50_compile_disabled multi_gpu=Off num_gpus=1 &
	CUDA_VISIBLE_DEVICES=5 python src/super_gradients/examples/train_from_recipe_example/train_from_recipe.py --config-name=cityscapes_stdc_seg50_compile_enabled  multi_gpu=Off num_gpus=1 &

all: imagenet_resnet50 cityscapes_ddrnet cityscapes_stdc_seg50
