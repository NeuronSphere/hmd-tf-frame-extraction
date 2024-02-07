import unittest
from pathlib import Path

from hmd_tf_frame_extraction.hmd_tf_frame_extraction import do_transform


class TestTransform:
    @unittest.mock.patch("hmd_tf_frame_extraction.hmd_tf_frame_extraction.os.listdir")
    @unittest.mock.path("hmd_tf_frame_extraction.hmd_tf_frame_extraction.shutil.copy")
    def test_exit_code(self, mock_listdir, mock_copy):
        mock_listdir.return_value = ["sample_input.txt"]

        exit_code = do_transform(
            "/hmd_transform/input", "/hmd_transform/output", "test-nid-1234", {}
        )

        assert exit_code == 0
        mock_listdir.assert_called_once_with(Path("/hmd_transform/input"))
        mock_copy.assert_called_once_with(
            Path("/hmd_transform/input") / "sample_input.txt",
            Path("/hmd_transform/output") / "sample_output.txt",
            "test-nid-1234",
            {},
        )
