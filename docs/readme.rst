hmd-tf-frame-extraction
==========================

NeuronSphere Notebook Transform to extract frames from a video, and performs operations on them.
It demonstrates the standard pattern for operationalizing Jupyter Notebooks into a NeuronSphere Transform.

Notebooks
-----------------------------------

There are three Jupyter Notebooks in ``./src/notebooks`` that each perform different operations on a video or images from video frames.
Each one is built into the Docker image for use in a Transform.
The ``notebook`` property in the ``TRANSFORM_INSTANCE_CONTEXT`` used when running the Transform Image determines which notebook is executed.
The expected structure of ``TRANSFORM_INSTANCE_CONTEXT`` is shown below.

.. code-block:: json

  {
      "notebook": "create_video.ipynb",
      "params": {
          "images_path": "/hmd_transform/output/images-out/IMG_3854/",
          "video_path": "/hmd_transform/output/video-out/"
      }
  }

Video Frame Extraction
+++++++++++++++++++++++++++++++++++++++

The notebook ``frame_extraction.ipynb`` is used to extract each frame of the videos located in ``/hmd_transform/input/videos/`` into JPEG images.
The images are stored in ``/hmd_transform/output/images`` for further processing or storage.

Object Detection
+++++++++++++++++++++++++++++++++++++++

The notebook ``object_detection.ipynb`` iterates over the images in ``/hmd_transform/output/images`` to detect when a person is in the frame.
It will start writing out a JPEG to ``/hmd_transform/output/images-out/<Video Name>``, with a bounding box, after it detects the first frame with a person.
It will continue write images with bounding boxes until it detects 10 frames without a person.

Create Video
+++++++++++++++++++++++++++++++++++++++

The notebook ``create_video.ipynb`` will join all images in ``/hmd_transform/output/images-out/<Video Name>`` into one new video, ``<Video Name>.avi``

Building & Testing
--------------------------------------

This project can be built using freely available CLI tools from NeuronSphere.
You will also need Python 3.9+, Docker v20+ and Docker Compose v2+.
First you will need to install the tools and setup your ``HMD_HOME``.

.. code-block:: bash

  pip install neuronsphere
  hmd configure

The ``hmd configure`` command will prompt you for a location for your ``HMD_HOME``. This can be any directory filepath and the directory will be created if it doesn't already exist.
You can accept the defaults for the other prompts.
It will also create a ``HMD_REPO_HOME`` directory that is used to store all NeuronSphere projects.
Clone or copy this project into that folder. It defaults to ``$HMD_HOME/projects``.

Build Transform Image
++++++++++++++++++++++++++++++++++++++

Once NeuronSphere tools are installed and configure, you can build the Transform Image for this project by running ``hmd build`` in the project root.
It will run the ``hmd docker build`` command that handles running the appropriate Docker bulid commands. The Dockerfile can be found in ``./src/docker/Dockerfile``.
The resulting image will be tagged, ``$HMD_CONTAINER_REGISTRY/hmd-tf-frame-extraction:0.1``. The ``HMD_CONTAINER_REGISTRY`` variable can be found in ``$HMD_HOME/.config/hmd.env`` file and will default to ``ghcr.io/neuronsphere``.

Running Tests
+++++++++++++++++++++++++++++++++++++

The NeuronSphere CLI tools come with a tool to run RobotFramework tests that integrate with the running local NeuronSphere.
First, you will need to copy one or more videos into the ``./test/videos`` directory.
The ``./test/`` directory is mounted into the running Transform Container as both ``/hmd_transform/input`` and ``/hmd_transform/output``.
Then, you should start the local NeuronSphere with ``hmd neuronsphere up``.
After all the containers start up, you can run ``hmd bender`` in this project's root to run the RobotFramework tests.