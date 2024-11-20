<script setup>
    import FloatingConfigurator from '@/components/FloatingConfigurator.vue';
</script>

<template>
    <FloatingConfigurator />
    <div
        class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden"
    >
        <div class="flex flex-col items-center justify-center">
            <div
                style="
                    border-radius: 56px;
                    padding: 0.3rem;
                    background: var(--primary-color);
                "
            >
                <div
                    class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20 flex flex-col items-center"
                    style="border-radius: 53px"
                >
                    <div class="gap-4 flex flex-col items-center">
                        <div
                            class="flex justify-center items-center border-2 border-green-500 rounded-full"
                            style="
                                width: 3.2rem;
                                height: 3.2rem;
                                border: 2px solid var(--primary-color);
                            "
                        >
                            <i
                                class="pi pi-fw pi-lock !text-2xl"
                                style="color: var(--primary-color)"
                            ></i>
                        </div>
                        <h1
                            class="text-surface-900 dark:text-surface-0 font-bold text-4xl lg:text-5xl mb-2"
                        >
                            Acceso denegado
                        </h1>
                        <span class="text-muted-color mb-8"
                            >Actualmente no tienes los permisos necesarios. Por
                            favor, conctacta con el administrador del
                            sitio.</span
                        >
                        <svg
                            width="270"
                            height="112"
                            viewBox="0 0 13.229166 6.6145833"
                            version="1.1"
                            id="svg5"
                        >
                            <defs id="defs2">
                                <linearGradient
                                    id="linearGradient1008"
                                    inkscape:swatch="solid"
                                >
                                    <stop
                                        style="
                                            stop-color: var(--primary-color);
                                            stop-opacity: 1;
                                        "
                                        offset="0"
                                        id="stop1006"
                                    />
                                </linearGradient>
                            </defs>
                            <g
                                inkscape:label="Capa 1"
                                inkscape:groupmode="layer"
                                id="layer1"
                            >
                                <g
                                    aria-label="cartel"
                                    transform="matrix(0.51795504,0,0,0.65173984,-1.0822243,-2.2204559)"
                                    id="text234"
                                    style="
                                        font-size: 13.3333px;
                                        line-height: 1.25;
                                        letter-spacing: 0px;
                                        word-spacing: 0px;
                                        white-space: pre;
                                        fill: none;
                                        fill-opacity: 1;
                                        stroke: var(--primary-color);
                                        stroke-width: 0.455386;
                                        stroke-opacity: 1;
                                    "
                                >
                                    <path
                                        d="M 8.694642,13.338202 H 2.3079394 V 3.6442157 H 8.694642 V 4.7900461 H 3.5969987 V 7.4462894 H 8.694642 V 8.5921199 H 3.5969987 V 12.192371 H 8.694642 Z"
                                        style="
                                            font-weight: bold;
                                            font-family: 'MS Reference Sans Serif';
                                            -inkscape-font-specification: 'MS Reference Sans Serif Bold';
                                            fill: none;
                                            fill-opacity: 1;
                                            stroke: var(--primary-color);
                                            stroke-width: 0.455386;
                                            stroke-opacity: 1;
                                        "
                                        id="path398"
                                    />
                                    <path
                                        d="m 17.080038,6.5738958 q 0,0.6445296 -0.227864,1.1979136 Q 16.63082,8.318683 16.227175,8.7223279 15.725874,9.2236287 15.042282,9.4775343 14.35869,9.7249295 13.317026,9.7249295 H 12.027967 V 13.338202 H 10.738908 V 3.6442157 h 2.630201 q 0.872394,0 1.477861,0.1497392 0.605467,0.1432288 1.074216,0.455728 0.553384,0.3710928 0.852863,0.9244768 0.305989,0.5533841 0.305989,1.3997361 z m -1.341143,0.032552 q 0,-0.5013008 -0.175781,-0.8723936 Q 15.387333,5.3629613 15.029261,5.1285869 14.716762,4.9267645 14.313117,4.8421293 13.915983,4.7509837 13.304005,4.7509837 h -1.276038 v 3.8736882 h 1.087237 q 0.781248,0 1.269528,-0.1367185 0.48828,-0.1432288 0.794269,-0.4492176 0.305988,-0.3124992 0.429686,-0.6575504 0.130208,-0.3450512 0.130208,-0.7747376 z"
                                        style="
                                            font-weight: bold;
                                            font-family: 'MS Reference Sans Serif';
                                            -inkscape-font-specification: 'MS Reference Sans Serif Bold';
                                            fill: none;
                                            fill-opacity: 1;
                                            stroke: var(--primary-color);
                                            stroke-width: 0.455386;
                                            stroke-opacity: 1;
                                        "
                                        id="path400"
                                    />
                                    <path
                                        d="m 27.412044,13.338202 h -1.28906 V 4.9853581 L 23.427679,10.668938 H 22.659451 L 19.983677,4.9853581 V 13.338202 H 18.779253 V 3.6442157 h 1.757808 l 2.584629,5.3971218 2.499994,-5.3971218 h 1.79036 z"
                                        style="
                                            font-weight: bold;
                                            font-family: 'MS Reference Sans Serif';
                                            -inkscape-font-specification: 'MS Reference Sans Serif Bold';
                                            fill: none;
                                            fill-opacity: 1;
                                            stroke: var(--primary-color);
                                            stroke-width: 0.455386;
                                            stroke-opacity: 1;
                                        "
                                        id="path402"
                                    />
                                </g>
                            </g>
                        </svg>
                        <div class="col-span-12 mt-8 text-center">
                            <Button
                                as="router-link"
                                label="Ir a inicio"
                                to="/"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
