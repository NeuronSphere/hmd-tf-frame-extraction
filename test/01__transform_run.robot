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
    FOR    ${index}    ${ctx}    IN ENUMERATE    @{obj_context}
        Run Transform Container    ${HMD_CONTAINER_REGISTRY}/hmd-tf-frame-extraction:0.1    ${ctx}
        ${images}=    List Files In Directory    ./images-out/${videos[${index}]}/
        Should Not Be Empty    ${images}
    END

Test Video Creation
    [Documentation]    Runs built Transform Image to detect person in frame
    FOR    ${index}    ${ctx}    IN ENUMERATE    @{video_context}
        Run Transform Container    ${HMD_CONTAINER_REGISTRY}/hmd-tf-frame-extraction:0.1    ${ctx}
        File Should Exist    ./video-out/${videos[${index}]}.avi
    END

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
    ${videos_out}=    List Directories In Directory    ./video-out/    !.gitkeep
    FOR    ${vid}    IN    @{videos_out}
        Remove File    ./video-out/${vid}
    END
