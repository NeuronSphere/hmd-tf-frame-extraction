import os

HMD_CONTAINER_REGISTRY = os.environ.get("HMD_CONTAINER_REGISTRY")

tf_context = {"notebook": "frame_extraction.ipynb", "params": {}}
obj_context = {
    "notebook": "object_detection.ipynb",
    "params": {
        "images_path": "/hmd_transform/output/images/IMG_3854/",
        "images_out_path": "/hmd_transform/output/images-out/IMG_3854/",
    },
}
video_context = {
    "notebook": "create_video.ipynb",
    "params": {
        "images_path": "/hmd_transform/output/images-out/IMG_3854/",
        "video_path": "/hmd_transform/output/video-out/",
    },
}
