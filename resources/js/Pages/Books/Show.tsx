import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout";
import {Head} from "@inertiajs/react";
import {PageProps} from "@/types";
import {useEffect, useState} from "react";
import axios from "axios";
import Buy from "@/Components/Buy";

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

export default function Show({auth, ...rest}: PageProps<any>) {

    const {id} = rest;

    const [loading, setLoading] = useState(false)
    const [book, setBook] = useState<any>({})

    useEffect(() => {
        setLoading(true)
        getBook(id).then(value => {
            setBook(value.data)
        }).catch(reason => {
            alert(JSON.stringify(reason?.message))
        }).finally(() => {
            setLoading(false)
        })
    }, []);

    return (
        <AuthenticatedLayout
            user={auth.user}
            {...rest}
        >
            <Head title="Add New"/>
            <div className="flex flex-col sm:justify-center items-center bg-gray-100 p-10">
                <div
                    className="w-full sm:max-w-screen-lg mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg">
                    {loading && (
                        <div className="flex justify-center items-center">
                            <div
                                className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-gray-900"></div>
                        </div>
                    ) || (
                        <>
                            {(book?.id) && (
                                <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                                    <div className="flex flex-col md:flex-row justify-center items-center">
                                        <div className="w-full md:w-1/2 lg:w-1/3 mb-8 md:mb-0">
                                            <img src={book.cover_image} alt={book.title}
                                                 className="w-full rounded-lg shadow-lg"/>
                                        </div>
                                        <div className="w-full md:w-1/2 lg:w-2/3 md:pl-8">
                                            <h2 className="text-3xl font-semibold mb-4">{book.title}</h2>
                                            <p className="text-gray-700 mb-4"><strong>Writer:</strong> {book.writer}</p>
                                            <div className="flex items-center justify-between mb-4">
                                                <span className="text-xl font-bold text-gray-900">${book.point}</span>
                                            </div>
                                            <p className="text-gray-600 text-sm">
                                                <strong>Tags:</strong> {book.tags}
                                            </p>
                                            <p className="text-gray-600 text-sm mt-4">
                                                <Buy book_id={book.id}/>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            ) || (
                                <div>Not Found!</div>
                            )}
                        </>
                    )}
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
