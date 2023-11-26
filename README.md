# Scientific illustration extraction

This code is an adaptation of the [YOLOv5](https://github.com/ultralytics/yolov5) object detector for the specific task of detecting historical scientific illustrations. It is a Pytorch implementation of "[Computer Vision and Historical Scientific Illustrations](https://iscd.huma-num.fr/media/vhs_iamaha.pdf)" paper (accepted at [IAMAHA 2023](https://iamaha.sciencesconf.org/) as an oral).

Check out our [paper](https://iscd.huma-num.fr/media/vhs_iamaha.pdf) and [webpage](http://imagine.enpc.fr/~baltacis/illustrationExtraction) for more details!

![teaser.jpg](https://iscd.huma-num.fr/media/teaser.jpg)

If you find this code useful, please consider starring the repository ⭐ and citing the paper:

```
@inproceedings{aouinti2023computer,
  title={{Computer Vision and Historical Scientific Illustrations}},
  author={Aouinti, Fouad and Baltaci, Zeynep Sonat and Aubry, Mathieu and Guilbaud, Alexandre and Lazaris, Stavros},
  booktitle={IAMAHA},
  year={2023}
}
```

## Installation :hammer_and_wrench:

### Prerequisites
>- **Sudo** privileges
>- **Bash** terminal
>- **Python** >= 3.8
>- **Git**:
>   - `sudo apt install git`
>   - Having configured [SSH access to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

### Repository

```
git clone https://github.com/faouinti/illustrationExtraction
cd illustrationExtraction
```

### Python dependencies

```
python -m venv .env
source .env/bin/activate
pip install -r requirements.txt
```

## Download datasets and models

To acquire the essential datasets, <!-- navigate to the `scripts/` directory in your terminal and --> execute the following command:

```bash
./scripts/download_datasets.sh
```

This command initiates the download of the following datasets:

- [SynDoc](https://github.com/monniert/docExtractor) dataset: 10k generated images with line-level page segmentation ground truth (19138 annotations)
- VHS dataset: 4451 images verified by historians (8620 annotations)

To download the trained models, run the following command:

```bash
./scripts/download_models.sh
```

This will retrieve our trained models:

- pre-trained on COCO and fine-tuned on SynDoc (`models/coco_syndoc.pt`)
- trained from scratch  (`models/scratch_vhs.pt`)
- pre-trained on COCO and fine-tuned on VHS (`models/coco_vhs.pt`)
- pre-trained on SynDoc and fine-tuned on VHS (`models/syndoc_vhs.pt`)

## How to use

In the `demo` folder, we provide a [Jupyter notebook](demo/demo.ipynb) designed to identify scientific illustrations within a specified image and store the corresponding results.

![notebook.png](https://iscd.huma-num.fr/media/notebook.png)
<img src="https://iscd.huma-num.fr/media/preview.jpg" width="200">
## Training

Pre-train on *COCO* and fine-tun on *SynDoc*:

```
python train.py --epochs 300 --data syndoc.yaml --weights yolov5s.pt
```

Train from *scratch* and fine-tune on *VHS*:

```
python train.py --epochs 300 --data vhs.yaml --weights '' --cfg yolov5s.yaml
```

Pre-train on *COCO* and fine-tun on *VHS*:

```
python train.py --epochs 300 --data vhs.yaml --weights yolov5s.pt
```

Pre-train on *SynDoc* and fine-tune on *VHS*:

```
python train.py --epochs 300 --data vhs.yaml --weights models/coco_syndoc.pt
```

- `--weights`: model path or triton URL
- `--data`: dataset.yaml path

## Validation

Validate a trained VHS detection model on a test dataset:

```
python val.py --weights path/to/model.pt --data path/to/data.yaml --task test --name path/to/output
```
- `--weights`: model path or triton URL (e.g. models/syndoc_vhs.pt)
- `--task`: train, val, test, speed or study
- `--name`: save to project/name

**NB:** `models/syndoc_vhs.pt` is the network pre-trained on SynDoc and fine-tuned on VHS.

## Inference

Run YOLOv5 detection inference on various sources (e.g., the VHS test images) and save the results in the `runs/detect` directory:

```
python detect.py --weights path/to/model.pt --source path/to/src/ --conf-thres 0.1 --save-crop
```

- `--source`: file/dir/URL/glob/screen/0(webcam) (e.g. `vhs/images/test/`)
- `--conf-thres`: filter predictions below the specified confidence level during inference
- `--save-crop`: save cropped prediction boxes

![vhs-dataset.jpg](https://iscd.huma-num.fr/media/vhs-dataset.jpg)

## Acknowledgements

This work was supported by the ANR (ANR project VHS [ANR-21-CE38-0008](https://anr.fr/Projet-ANR-21-CE38-0008)). MA and SB were supported by ERC project DISCOVER funded by the European Union's Horizon Europe Research and Innovation programme under grant agreement [No. 101076028](https://cordis.europa.eu/project/id/101076028). Views and opinions expressed are however those of the authors only and do not necessarily reflect those of the European Union. Neither the European Union nor the granting authority can be held responsible for them.