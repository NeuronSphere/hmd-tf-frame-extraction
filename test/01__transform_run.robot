*** Settings ***
Library           OperatingSystem
Library           hmd_lib_robot_shared.containers_lib.ContainerLib
Variables         tx_vars.py
Test Setup        Test Cleanup

*** Test Cases ***
Test Frame Extraction
    [Documentation]    Runs built Transform Image
    Run Transform Container    ${HMD_CONTAINER_REGISTRY}/hmd-tf-frame-extraction:0.1    ${tf_context}
    ${images}=    List Files In Directory    ./images/IMG_3854/
    Length Should Be    ${images}    403

Test Person Detection
    [Documentation]    Runs built Transform Image to detect person in frame
    Run Transform Container    ${HMD_CONTAINER_REGISTRY}/hmd-tf-frame-extraction:0.1    ${obj_context}
    ${images}=    List Files In Directory    ./images-out/IMG_3854/
    Length Should Be    ${images}    226

Test Video Creation
    [Documentation]    Runs built Transform Image to detect person in frame
    Run Transform Container    ${HMD_CONTAINER_REGISTRY}/hmd-tf-frame-extraction:0.1    ${video_context}
    File Should Exist    ./video-out/video.avi

*** Keywords ***
Test Cleanup
    ${images}=    List Directories In Directory    ./images/    !.gitkeep
    FOR    ${dir}    IN    @{images}
        Remove Directory    ${dir}    ${True}
    END
    ${images}=    List Directories In Directory    ./images-out/    !.gitkeep
    FOR    ${dir}    IN    @{images}
        Remove Directory    ${dir}    ${True}
    END
    Remove File    ./video-out/video.avi
