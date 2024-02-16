import os

HMD_CONTAINER_REGISTRY = os.environ.get("HMD_CONTAINER_REGISTRY")

videos = []

for file_ in os.listdir("./videos"):
    if file_ == ".gitkeep":
        continue
    videos.append(os.path.splitext(file_)[0])


tf_context = {"notebook": "frame_extraction.ipynb", "params": {}}
obj_context = [
    {
        "notebook": "object_detection.ipynb",
        "params": {
            "images_path": f"/hmd_transform/output/images/{video}/",
            "images_out_path": f"/hmd_transform/output/images-out/{video}/",
        },
    }
    for video in videos
]
video_context = [
    {
        "notebook": "create_video.ipynb",
        "params": {
            "images_path": f"/hmd_transform/output/images-out/{video}/",
            "video_path": "/hmd_transform/output/video-out/",
            "video_filename": video,
        },
    }
    for video in videos
]
