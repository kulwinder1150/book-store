import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout";
import {Head, Link, router, useForm} from "@inertiajs/react";
import {PageProps} from "@/types";
import {FormEventHandler, useEffect, useState} from "react";
import InputLabel from "@/Components/InputLabel";
import TextInput from "@/Components/TextInput";
import InputError from "@/Components/InputError";
import PrimaryButton from "@/Components/PrimaryButton";
import axios from "axios";

async function getBook(id: string | number) {

    let config = {
        method: 'get',
        maxBodyLength: Infinity,
        url: `/api/books/${id}`,
        headers: {
            'Accept': 'application/json',
        },
    };

    return axios.request(config);
}

export default function New({auth, ...rest}: PageProps<any>) {

    const {id} = rest;

    const {
        data,
        setData,
        processing,
        errors,
        setError,
    } = useForm({
        title: '',
        writer: '',
        cover_image: '',
        point: '',
        tags: '',
    });

    const [loading, setLoading] = useState(false)

    const submit: FormEventHandler = (e) => {
        e.preventDefault();

        const formData = new FormData();

        formData.append('title', data.title);
        formData.append('writer', data.writer);
        formData.append('point', data.point);
        formData.append('tags', data.tags);
        formData.append('_method', 'PUT');

        setLoading(true);
        setError('title', '');
        setError('writer', '');
        setError('cover_image', '');
        setError('point', '');
        setError('tags', '');

        // Append the file to FormData
        const fileInput = document.getElementById('cover_image') as HTMLInputElement;
        formData.append('cover_image', fileInput.files?.[0] as Blob);

        // Make a POST request using Axios
        axios.post(`/api/books/${id}`, formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
                'Accept': 'application/json',
            }
        })
            .then(function (_response) {
                router.get(route('books'));
            })
            .catch(function (error) {
                console.log('error', error)
                const errorData = error?.response?.data?.errors

                if (errorData?.title?.[0]) setError('title', errorData.title[0])
                if (errorData?.writer?.[0]) setError('writer', errorData.writer[0])
                if (errorData?.cover_image?.[0]) setError('cover_image', errorData.cover_image[0])
                if (errorData?.point?.[0]) setError('point', errorData.point[0])
                if (errorData?.tags?.[0]) setError('tags', errorData.tags[0])
            }).finally(() => {
            setLoading(false)
        });
    };

    const [book, setBook] = useState<any>({})
    const [load, setLoad] = useState(false)

    useEffect(() => {
        setLoad(true)
        getBook(id).then(value => {
            const book = value.data;
            setBook(book);
            setData({
                ...data,
                title: book.title,
                writer: book.writer,
                point: book.point,
                tags: book.tags,
            })
        }).catch(reason => {
            alert(JSON.stringify(reason?.message))
        }).finally(() => {
            setLoad(false)
        })
    }, []);

    return (
        <AuthenticatedLayout
            user={auth.user}
            {...rest}
            header={<h2 className="font-semibold text-xl text-gray-800 leading-tight">Edit Book</h2>}
        >
            <Head title="Add New"/>
            <div className="flex flex-col sm:justify-center items-center bg-gray-100 p-10">
                <div className="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg">
                    {load && (
                        <div className="flex justify-center items-center">
                            <div
                                className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-gray-900"></div>
                        </div>
                    ) || (
                        <form onSubmit={submit}>
                            <div>
                                <InputLabel htmlFor="title" value="Title"/>
                                <TextInput
                                    id="title"
                                    name="title"
                                    value={data.title}
                                    className="mt-1 block w-full"
                                    autoComplete="title"
                                    isFocused={true}
                                    onChange={(e) => {
                                        setError('title', '');
                                        setData('title', e.target.value);
                                    }}
                                />
                                <InputError message={errors.title} className="mt-2"/>
                            </div>
                            <div className={'mt-2'}>
                                <InputLabel htmlFor="writer" value="Writer"/>
                                <TextInput
                                    id="writer"
                                    name="writer"
                                    value={data.writer}
                                    className="mt-1 block w-full"
                                    autoComplete="writer"
                                    isFocused={true}
                                    onChange={(e) => {
                                        setError('writer', '');
                                        setData('writer', e.target.value);
                                    }}
                                />
                                <InputError message={errors.writer} className="mt-2"/>
                            </div>
                            <div className={'mt-2'}>
                                <InputLabel htmlFor="cover_image" value="Cover Image"/>
                                <input
                                    type={'file'}
                                    id="cover_image"
                                    name="cover_image"
                                    value={data.cover_image}
                                    className="mt-1 block w-full"
                                    onChange={(e) => {
                                        setError('cover_image', '');
                                        setData('cover_image', e.target.value);
                                        setBook((prev: any) => ({
                                            ...prev,
                                            cover_image: '',
                                        }));
                                    }}
                                />
                                <InputError message={errors.cover_image} className="mt-2"/>
                                {book.cover_image && (
                                    <img className={'mt-2'} src={book.cover_image} alt={'cover image'} width={50}
                                         height={50}/>
                                )}
                            </div>
                            <div className={'mt-2'}>
                                <InputLabel htmlFor="point" value="Price"/>
                                <TextInput
                                    id="point"
                                    name="point"
                                    value={data.point}
                                    className="mt-1 block w-full"
                                    autoComplete="point"
                                    isFocused={true}
                                    onChange={(e) => {
                                        setError('point', '');
                                        setData('point', e.target.value);
                                    }}
                                    type={'number'}
                                    step={0.01}
                                    min={0}
                                />
                                <InputError message={errors.point} className="mt-2"/>
                            </div>
                            <div className={'mt-2 mb-4'}>
                                <InputLabel htmlFor="point" value="Tags"/>
                                <textarea
                                    name="tags"
                                    id="tags"
                                    value={data.tags}
                                    className="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm mt-1 block w-full"
                                    onChange={(e) => {
                                        setError('tags', '')
                                        setData('tags', e.target.value);
                                    }}
                                    placeholder={'fiction, science'}
                                ></textarea>
                                <p className={'text-gray-500 text-sm'}>Keywords should all be in lowercase and separated
                                    by
                                    commas. e.g. fiction, non-fiction, science, essay</p>
                                <InputError message={errors.tags} className="mt-2"/>
                            </div>
                            <hr/>
                            <div className="flex items-center justify-end mt-4">
                                <Link
                                    href={route('books')}
                                    className="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                >
                                    Go to Books
                                </Link>
                                <PrimaryButton className="ms-4" disabled={processing || loading}>
                                    Update
                                </PrimaryButton>
                            </div>
                        </form>
                    )}
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
