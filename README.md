# Scientific illustration extraction

> ### *VHS is a research project funded and supported by the Agence Nationale pour la Recherche*
> - **VHS** [ANR-21-CE38-0008](https://anr.fr/Projet-ANR-21-CE38-0008): computer Vision and Historical analysis of Scientific illustration circulation

illustrationExtractor is an adaptation of the [YOLOv5](https://github.com/ultralytics/yolov5) object detector for the specific task of detecting historical scientific illustrations. It is a Pytorch implementation of "[Computer Vision and Historical Scientific Illustrations](https://iscd.huma-num.fr/media/vhs_iamaha.pdf)" paper (accepted at [IAMAHA 2023](https://iamaha.sciencesconf.org/) as an oral).

Check out our [paper](https://iscd.huma-num.fr/media/vhs_iamaha.pdf) and [webpage](https://vhs.hypotheses.org) for more details!

![teaser.jpg](https://iscd.huma-num.fr/media/teaser.jpg)

If you find this code useful, please consider starring the repository ⭐ and citing the paper:

```
@inproceedings{aouinti2023computer,
  title={{Computer Vision and Historical Scientific Illustrations}},
  author={Aouinti, Fouad and Baltaci, Zeynep Sonat and Aubry, Mathieu and Guilbaud, Alexandre and Lazaris, Stavros},
  booktitle={IAMAHA},
  year={2023},
}
```

## Installation :hammer_and_wrench:

### Prerequisites
>- **Sudo** privileges
>- **Bash** terminal
>- **Python>=3.8.0**
>- **Git**

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

## Download resources and models

To download the necessary resources and models, run the following command in a terminal inside the `scripts/` directory:

```bash
./download.sh
```

This command will download:

- [SynDoc](https://github.com/monniert/docExtractor) dataset: 10k generated images with line-level page segmentation ground truth (19138 annotations)
- Our trained model on SynDoc dataset (`models/syndoc.pt`)
- VHS dataset: 5788 images verified by historians (11738 annotations)
- Our trained model on VHS dataset (`models/vhs.pt`)

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
python train.py --epochs 300 --data vhs.yaml --weights ../models/syndoc.pt
```

- `--weights`: model path or triton URL (e.g. `models/syndoc.pt`)
- `--data`: dataset.yaml path (e.g. `vhs.yaml`)

## Validation

Validate a trained VHS detection model on a test dataset:

```
python val.py --weights path/to/model.pt --data path/to/data.yaml --task test
```

- `--weights`: model path or triton URL (e.g. `models/vhs.pt`)
- `--task`: train, val, test, speed or study

**NB:** `../models/vhs.pt` is the network pre-trained on SynDoc and fine-tuned on VHS.

## Inference

Run YOLOv5 detection inference on various sources (e.g., the VHS test images) and save the results in the `runs/detect` directory:

```
python detect.py --weights path/to/model.pt --source path/to/src/ --save-crop
```

- `--source`: file/dir/URL/glob/screen/0(webcam) (e.g. `vhs/images/test/`)
- `--save-crop`: save cropped prediction boxes

![teaser.jpg](https://iscd.huma-num.fr/media/vhs-dataset.jpg)