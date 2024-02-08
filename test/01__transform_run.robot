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

*** Keywords ***
Test Cleanup
    ${images}=    List Directories In Directory    ./images/    !.gitkeep
    FOR    ${dir}    IN    @{images}
        Remove Directory    ${dir}    ${True}
    END
